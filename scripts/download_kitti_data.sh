#!/usr/bin/env bash

readonly CURRENT_DIR=$(dirname $(realpath $0))
readonly DATA_PATH=$(realpath ${CURRENT_DIR}/../data)


DOWNLOAD_FILES='
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_calib.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0001/2011_09_26_drive_0001_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0001/2011_09_26_drive_0001_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0002/2011_09_26_drive_0002_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0002/2011_09_26_drive_0002_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0005/2011_09_26_drive_0005_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0005/2011_09_26_drive_0005_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0009/2011_09_26_drive_0009_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0009/2011_09_26_drive_0009_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0011/2011_09_26_drive_0011_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0011/2011_09_26_drive_0011_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0013/2011_09_26_drive_0013_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0013/2011_09_26_drive_0013_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0014/2011_09_26_drive_0014_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0014/2011_09_26_drive_0014_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0015/2011_09_26_drive_0015_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0015/2011_09_26_drive_0015_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0017/2011_09_26_drive_0017_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0017/2011_09_26_drive_0017_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0018/2011_09_26_drive_0018_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0018/2011_09_26_drive_0018_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0019/2011_09_26_drive_0019_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0019/2011_09_26_drive_0019_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0020/2011_09_26_drive_0020_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0020/2011_09_26_drive_0020_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0022/2011_09_26_drive_0022_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0022/2011_09_26_drive_0022_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0023/2011_09_26_drive_0023_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0023/2011_09_26_drive_0023_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0027/2011_09_26_drive_0027_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0027/2011_09_26_drive_0027_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0028/2011_09_26_drive_0028_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0028/2011_09_26_drive_0028_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0029/2011_09_26_drive_0029_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0029/2011_09_26_drive_0029_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0032/2011_09_26_drive_0032_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0032/2011_09_26_drive_0032_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0035/2011_09_26_drive_0035_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0035/2011_09_26_drive_0035_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0036/2011_09_26_drive_0036_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0036/2011_09_26_drive_0036_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0039/2011_09_26_drive_0039_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0039/2011_09_26_drive_0039_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0046/2011_09_26_drive_0046_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0046/2011_09_26_drive_0046_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0048/2011_09_26_drive_0048_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0048/2011_09_26_drive_0048_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0051/2011_09_26_drive_0051_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0051/2011_09_26_drive_0051_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0052/2011_09_26_drive_0052_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0052/2011_09_26_drive_0052_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0056/2011_09_26_drive_0056_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0056/2011_09_26_drive_0056_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0057/2011_09_26_drive_0057_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0057/2011_09_26_drive_0057_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0059/2011_09_26_drive_0059_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0059/2011_09_26_drive_0059_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0060/2011_09_26_drive_0060_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0060/2011_09_26_drive_0060_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0061/2011_09_26_drive_0061_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0061/2011_09_26_drive_0061_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0064/2011_09_26_drive_0064_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0064/2011_09_26_drive_0064_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0070/2011_09_26_drive_0070_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0070/2011_09_26_drive_0070_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0079/2011_09_26_drive_0079_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0079/2011_09_26_drive_0079_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0084/2011_09_26_drive_0084_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0084/2011_09_26_drive_0084_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0086/2011_09_26_drive_0086_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0086/2011_09_26_drive_0086_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0087/2011_09_26_drive_0087_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0087/2011_09_26_drive_0087_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0091/2011_09_26_drive_0091_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0091/2011_09_26_drive_0091_tracklets.zip

    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0093/2011_09_26_drive_0093_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0093/2011_09_26_drive_0093_tracklets.zip
'

DOWNLOAD_FILES_WITHOUT_TRACKLETS='
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0001/2011_09_26_drive_0001_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0002/2011_09_26_drive_0002_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0005/2011_09_26_drive_0005_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0009/2011_09_26_drive_0009_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0011/2011_09_26_drive_0011_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0013/2011_09_26_drive_0013_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0014/2011_09_26_drive_0014_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0015/2011_09_26_drive_0015_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0017/2011_09_26_drive_0017_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0018/2011_09_26_drive_0018_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0019/2011_09_26_drive_0019_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0020/2011_09_26_drive_0020_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0022/2011_09_26_drive_0022_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0023/2011_09_26_drive_0023_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0027/2011_09_26_drive_0027_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0028/2011_09_26_drive_0028_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0029/2011_09_26_drive_0029_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0032/2011_09_26_drive_0032_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0035/2011_09_26_drive_0035_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0036/2011_09_26_drive_0036_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0039/2011_09_26_drive_0039_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0046/2011_09_26_drive_0046_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0048/2011_09_26_drive_0048_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0051/2011_09_26_drive_0051_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0052/2011_09_26_drive_0052_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0056/2011_09_26_drive_0056_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0057/2011_09_26_drive_0057_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0059/2011_09_26_drive_0059_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0060/2011_09_26_drive_0060_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0061/2011_09_26_drive_0061_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0064/2011_09_26_drive_0064_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0070/2011_09_26_drive_0070_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0079/2011_09_26_drive_0079_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0084/2011_09_26_drive_0084_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0086/2011_09_26_drive_0086_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0087/2011_09_26_drive_0087_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0091/2011_09_26_drive_0091_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0093/2011_09_26_drive_0093_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0095/2011_09_26_drive_0095_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0096/2011_09_26_drive_0096_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0104/2011_09_26_drive_0104_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0106/2011_09_26_drive_0106_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0113/2011_09_26_drive_0113_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_26_drive_0117/2011_09_26_drive_0117_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_29_drive_0004/2011_09_29_drive_0004_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_29_drive_0071/2011_09_29_drive_0071_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_30_drive_0016/2011_09_30_drive_0016_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_30_drive_0018/2011_09_30_drive_0018_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_30_drive_0020/2011_09_30_drive_0020_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_30_drive_0027/2011_09_30_drive_0027_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_30_drive_0028/2011_09_30_drive_0028_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_30_drive_0033/2011_09_30_drive_0033_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_09_30_drive_0034/2011_09_30_drive_0034_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_10_03_drive_0034/2011_10_03_drive_0034_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_10_03_drive_0042/2011_10_03_drive_0042_sync.zip
    https://s3.eu-central-1.amazonaws.com/avg-kitti/raw_data/2011_10_03_drive_0047/2011_10_03_drive_0047_sync.zip
'

for download_file in ${DOWNLOAD_FILES_WITHOUT_TRACKLETS}; do
    file_name=$(basename $download_file)
    if [ ! -f $DATA_PATH/$file_name ]; then
        wget ${download_file} -P $DATA_PATH
        unzip $DATA_PATH/${file_name} -d ${DATA_PATH}
    fi
done
