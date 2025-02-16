import numpy as np
import tensorflow as tf
import os

from models import StixelLoss
from data_loader import WaymoStixelDataset


def main():
    print(os.getcwd())
    loss_set = WaymoStixelDataset(
        data_path=os.path.join(os.getcwd(), "utility"),
        ground_truth_path=os.path.join(os.getcwd(), "utility", "waymo_loss.txt")
    )
    loss_func = StixelLoss()
    # Ground Truth Data
    img, target = loss_set.__getitem__(0)
    print(target)
    print(target.shape)
    # NN prediction
    predict = tf.random.uniform((1, 240, 160), minval=-300.51, maxval=300.49)

    # print(predict)

    print(loss_func.get_config())
    print(loss_func.call(target, predict))


if __name__ == '__main__':
    main()
