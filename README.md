# FACE-DETECTION_HOG-SVM

We train a model using HOG feature and Libsvm for detect Faces in image.

## Prerequisites
1) matlab (with compiler)

2) LibSVM (include path in matlab)


to detect the face use command => detect(image,model,wsize)
                                         
                                         where image is input image
                                               
                                               model is trained model (save in model_t0_24_32.mat)
                                               
                                               wsize is moving window size ( [24,32]*3)

