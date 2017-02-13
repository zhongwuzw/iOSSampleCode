//
//  ZWQuadTree.h
//  ZWQuadTree
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef struct ZWQuadTreeNodeData {//包含经纬度、data字段包含其他信息，如旅馆电话等
    double x;
    double y;
    void* data;
} ZWQuadTreeNodeData;
ZWQuadTreeNodeData ZWQuadTreeNodeDataMake(double x, double y, void* data);

typedef struct ZWBoundingBox {
    double x0; double y0;
    double xf; double yf;
} ZWBoundingBox;
ZWBoundingBox ZWBoundingBoxMake(double x0, double y0, double xf, double yf);

typedef struct quadTreeNode {
    struct quadTreeNode* northWest;
    struct quadTreeNode* northEast;
    struct quadTreeNode* southWest;
    struct quadTreeNode* southEast;
    ZWBoundingBox boundingBox;  //该节点的框的范围
    int bucketCapacity;
    ZWQuadTreeNodeData *points;
    int count;
} ZWQuadTreeNode;
ZWQuadTreeNode* ZWQuadTreeNodeMake(ZWBoundingBox boundary, int bucketCapacity);

void ZWFreeQuadTreeNode(ZWQuadTreeNode* node, ZWQuadTreeNode* root);

bool ZWBoundingBoxContainsData(ZWBoundingBox box, ZWQuadTreeNodeData data);
bool ZWBoundingBoxIntersectsBoundingBox(ZWBoundingBox b1, ZWBoundingBox b2);

typedef void(^ZWQuadTreeTraverseBlock)(ZWQuadTreeNode* currentNode);
void ZWQuadTreeTraverse(ZWQuadTreeNode* node, ZWQuadTreeTraverseBlock block);

typedef void(^ZWDataReturnBlock)(ZWQuadTreeNodeData data);
void ZWQuadTreeGatherDataInRange(ZWQuadTreeNode* node, ZWBoundingBox range, ZWDataReturnBlock block);

bool ZWQuadTreeNodeInsertData(ZWQuadTreeNode* node, ZWQuadTreeNodeData data);
ZWQuadTreeNode* TBQuadTreeBuildWithData(ZWQuadTreeNodeData *data, NSInteger count, ZWBoundingBox boundingBox, int capacity);
