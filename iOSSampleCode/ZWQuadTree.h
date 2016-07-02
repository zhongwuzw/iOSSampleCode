//
//  ZWQuadTree.h
//  ZWQuadTree
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef struct TBQuadTreeNodeData {//包含经纬度、data字段包含其他信息，如旅馆电话等
    double x;
    double y;
    void* data;
} TBQuadTreeNodeData;
TBQuadTreeNodeData TBQuadTreeNodeDataMake(double x, double y, void* data);

typedef struct TBBoundingBox {
    double x0; double y0;
    double xf; double yf;
} TBBoundingBox;
TBBoundingBox TBBoundingBoxMake(double x0, double y0, double xf, double yf);

typedef struct quadTreeNode {
    struct quadTreeNode* northWest;
    struct quadTreeNode* northEast;
    struct quadTreeNode* southWest;
    struct quadTreeNode* southEast;
    TBBoundingBox boundingBox;  //该节点的框的范围
    int bucketCapacity;
    TBQuadTreeNodeData *points;
    int count;
} TBQuadTreeNode;
TBQuadTreeNode* TBQuadTreeNodeMake(TBBoundingBox boundary, int bucketCapacity);

void TBFreeQuadTreeNode(TBQuadTreeNode* node);

bool TBBoundingBoxContainsData(TBBoundingBox box, TBQuadTreeNodeData data);
bool TBBoundingBoxIntersectsBoundingBox(TBBoundingBox b1, TBBoundingBox b2);

typedef void(^TBQuadTreeTraverseBlock)(TBQuadTreeNode* currentNode);
void TBQuadTreeTraverse(TBQuadTreeNode* node, TBQuadTreeTraverseBlock block);

typedef void(^TBDataReturnBlock)(TBQuadTreeNodeData data);
void TBQuadTreeGatherDataInRange(TBQuadTreeNode* node, TBBoundingBox range, TBDataReturnBlock block);

bool TBQuadTreeNodeInsertData(TBQuadTreeNode* node, TBQuadTreeNodeData data);
TBQuadTreeNode* TBQuadTreeBuildWithData(TBQuadTreeNodeData *data, NSInteger count, TBBoundingBox boundingBox, int capacity);