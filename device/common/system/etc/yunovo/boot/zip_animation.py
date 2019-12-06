import zipfile
import os
import shutil

mediaDir = "media/"
part0Dir = "part0/"
descFile = "desc.txt"
configDir = "config/"
configFile = "config/car_list.cfg"
logoDir = "logo/"


def generateDesc():
    f = open(descFile, "w")
    f.writelines("1024 600 1\n")
    f.writelines("p 0 0 part0\n")
    f.write("\n")
    f.close()


def generateZip(file, carType):
    if not os.path.exists(part0Dir):
        os.mkdir(part0Dir)
    shutil.copyfile(os.path.join(logoDir+file), part0Dir + file)
    generateDesc()
    animationiName = 'animation_' + carType + '.zip'
    f = zipfile.ZipFile(animationiName, 'w', zipfile.ZIP_STORED)
    f.write(descFile)
    for dirpath, dirnames, filenames in os.walk(part0Dir):
        for filename in filenames:
            f.write(os.path.join(dirpath, filename))
    f.close()
    return animationiName


def parseLogo():
    configData = {}
    fileList = os.listdir(logoDir)
    for f in fileList:
        print("f:"+f)
        if not f.endswith("png"):
            continue
        carType = (f.split("."))[0].split("logo_")[1]
        #configData[carType] = f + "," + animationiName
        if "default" in f:
            continue
        else:
            animationiName = generateZip(f, carType)
            print("animationiName:"+animationiName)
            configData[carType] = f + "," + animationiName
            if not os.path.exists(mediaDir):
                os.makedirs(mediaDir)
            shutil.move(animationiName, mediaDir + animationiName)
            os.remove(descFile)
            shutil.rmtree(part0Dir)
    configData["default"]="logo_default.png"
    if not os.path.exists(configDir):
        os.makedirs(configDir)
    if not os.path.exists(configFile):
        os.mknod(configFile)
    f = open(configFile, "w")
    result =sorted(configData.keys())
    for data in result:
        f.writelines(data + "=" + configData[data])
        f.write("\n")
    f.close()

parseLogo()
