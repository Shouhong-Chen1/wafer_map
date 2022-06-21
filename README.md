# wafer_map
Wafer Map Failure Pattern Recognition 

#Wafer Map Failure Patterns Recognition based on Deep Convolutional Neural Network





--------------------------------------------------------------------------------------------------------------------
Dateset：
Nine_Type: A total of 53925 wafer map with nine defect pattern
per_0: wafer map after gray and median filtering
--------------------------------------------------------------------------------------------------------------------

(1)run mycnn.m 

Two different wafer map as input to CNN
experimentData = 1, Use original wafer map as input of CNN
experimentData = 2, Use the wafer Use the wafer after graying and median filtering as the input of CNN



(2)run MulSource.m

use the method of decision-level information entropy fusion  to realize the final classification of the wafer map
