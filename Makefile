APP_NAME = dictionary
BUILD_DIR = ./bin/Visual\ Dictionary.app/contents/MacOS/
C_FILES = ./src/main.cpp

APP_DEFINES:= 
APP_INCLUDES:= -I./src/vendors/GLFW -framework Cocoa -framework OpenGL -framework IOKit
APP_LINKERS:= -L./src/vendors/GLFW/lib -lglfw3

build:
	clang $(C_FILES) -o $(BUILD_DIR)/$(APP_NAME) $(APP_INCLUDES) $(APP_LINKERS)