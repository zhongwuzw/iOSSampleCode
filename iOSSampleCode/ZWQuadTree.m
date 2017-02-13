//
//  ZWQuadTree.m
//  ZWQuadTree
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWQuadTree.h"
#import "ZWCoordinateQuadTree.h"

#pragma mark - Constructors

ZWQuadTreeNodeData ZWQuadTreeNodeDataMake(double x, double y, void* data)
{
    ZWQuadTreeNodeData d; d.x = x; d.y = y; d.data = data;
    return d;
}

ZWBoundingBox ZWBoundingBoxMake(double x0, double y0, double xf, double yf)
{
    ZWBoundingBox bb; bb.x0 = x0; bb.y0 = y0; bb.xf = xf; bb.yf = yf;
    return bb;
}

ZWQuadTreeNode* ZWQuadTreeNodeMake(ZWBoundingBox boundary, int bucketCapacity)
{
    ZWQuadTreeNode* node = (ZWQuadTreeNode*)malloc(sizeof(ZWQuadTreeNode));
    if (node != NULL) {
        node->northWest = NULL;
        node->northEast = NULL;
        node->southWest = NULL;
        node->southEast = NULL;
        
        node->boundingBox = boundary;
        node->bucketCapacity = bucketCapacity;
        node->count = 0;
        node->points = (ZWQuadTreeNodeData*)malloc(sizeof(ZWQuadTreeNodeData) * bucketCapacity);
    }
    
    return node;
}

#pragma mark - Bounding Box Functions

bool ZWBoundingBoxContainsData(ZWBoundingBox box, ZWQuadTreeNodeData data)
{
    bool containsX = box.x0 <= data.x && data.x <= box.xf;
    bool containsY = box.y0 <= data.y && data.y <= box.yf;

    return containsX && containsY;
}

bool ZWBoundingBoxIntersectsBoundingBox(ZWBoundingBox b1, ZWBoundingBox b2)
{
    return (b1.x0 <= b2.xf && b1.xf >= b2.x0 && b1.y0 <= b2.yf && b1.yf >= b2.y0);
}

#pragma mark - Quad Tree Functions
/**
 *  @author 钟武, 16-07-01 10:07:29
 *
 *  @brief 将节点拆分成4个框框
 *
 *  @param node
 */
void ZWQuadTreeNodeSubdivide(ZWQuadTreeNode* node)
{
    ZWBoundingBox box = node->boundingBox;

    double xMid = (box.xf + box.x0) / 2.0;
    double yMid = (box.yf + box.y0) / 2.0;

    ZWBoundingBox northWest = ZWBoundingBoxMake(box.x0, box.y0, xMid, yMid);
    node->northWest = ZWQuadTreeNodeMake(northWest, node->bucketCapacity);

    ZWBoundingBox northEast = ZWBoundingBoxMake(xMid, box.y0, box.xf, yMid);
    node->northEast = ZWQuadTreeNodeMake(northEast, node->bucketCapacity);

    ZWBoundingBox southWest = ZWBoundingBoxMake(box.x0, yMid, xMid, box.yf);
    node->southWest = ZWQuadTreeNodeMake(southWest, node->bucketCapacity);

    ZWBoundingBox southEast = ZWBoundingBoxMake(xMid, yMid, box.xf, box.yf);
    node->southEast = ZWQuadTreeNodeMake(southEast, node->bucketCapacity);
}

/**
 *  @author 钟武, 16-07-01 10:07:10
 *
 *  @brief 建立四叉树
 *
 *  @param node 根节点
 *  @param data 插入的数据
 *
 *  @return
 */
bool ZWQuadTreeNodeInsertData(ZWQuadTreeNode* node, ZWQuadTreeNodeData data)
{
    if (!ZWBoundingBoxContainsData(node->boundingBox, data)) {
        return false;
    }

    if (node->count < node->bucketCapacity) {
        node->points[node->count++] = data;
        return true;
    }

    if (node->northWest == NULL) {
        ZWQuadTreeNodeSubdivide(node);
    }

    if (ZWQuadTreeNodeInsertData(node->northWest, data)) return true;
    if (ZWQuadTreeNodeInsertData(node->northEast, data)) return true;
    if (ZWQuadTreeNodeInsertData(node->southWest, data)) return true;
    if (ZWQuadTreeNodeInsertData(node->southEast, data)) return true;

    return false;
}

void ZWQuadTreeGatherDataInRange(ZWQuadTreeNode* node, ZWBoundingBox range, ZWDataReturnBlock block)
{
    if (!ZWBoundingBoxIntersectsBoundingBox(node->boundingBox, range)) {
        return;
    }

    for (int i = 0; i < node->count; i++) {
        if (ZWBoundingBoxContainsData(range, node->points[i])) {
            block(node->points[i]);
        }
    }

    if (node->northWest == NULL) {
        return;
    }

    ZWQuadTreeGatherDataInRange(node->northWest, range, block);
    ZWQuadTreeGatherDataInRange(node->northEast, range, block);
    ZWQuadTreeGatherDataInRange(node->southWest, range, block);
    ZWQuadTreeGatherDataInRange(node->southEast, range, block);
}

void ZWQuadTreeTraverse(ZWQuadTreeNode* node, ZWQuadTreeTraverseBlock block)
{
    block(node);

    if (node->northWest == NULL) {
        return;
    }

    ZWQuadTreeTraverse(node->northWest, block);
    ZWQuadTreeTraverse(node->northEast, block);
    ZWQuadTreeTraverse(node->southWest, block);
    ZWQuadTreeTraverse(node->southEast, block);
}

ZWQuadTreeNode* TBQuadTreeBuildWithData(ZWQuadTreeNodeData *data, NSInteger count, ZWBoundingBox boundingBox, int capacity)
{
    ZWQuadTreeNode* root = ZWQuadTreeNodeMake(boundingBox, capacity);
    for (int i = 0; i < count; i++) {
        ZWQuadTreeNodeInsertData(root, data[i]);
    }

    return root;
}

void ZWFreeQuadTreeNode(ZWQuadTreeNode* node,ZWQuadTreeNode* root)
{
    if (node->northWest != NULL) ZWFreeQuadTreeNode(node->northWest,root);
    if (node->northEast != NULL) ZWFreeQuadTreeNode(node->northEast,root);
    if (node->southWest != NULL) ZWFreeQuadTreeNode(node->southWest,root);
    if (node->southEast != NULL) ZWFreeQuadTreeNode(node->southEast,root);

    if (node == root) {
        ;
    }
    for (int i=0; i < node->count; i++) {
        //修复内存泄露
        free(((ZWHotelInfo *)(node->points[i].data))->hotelName);
        ((ZWHotelInfo *)(node->points[i].data))->hotelName = NULL;
        free(((ZWHotelInfo *)(node->points[i].data))->hotelPhoneNumber);
        ((ZWHotelInfo *)(node->points[i].data))->hotelPhoneNumber = NULL;
        free((ZWHotelInfo *)(node->points[i].data));
        node->points[i].data = NULL;
    }
    free(node->points);
    node->points = NULL;
    free(node);
    node = NULL;
}
