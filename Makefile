# CXX = clang
# APP_NAME = dictionary
# BUILD_DIR = ./bin/Visual\ Dictionary.app/contents/MacOS/
# C_FILES = ./src/main.cpp

# APP_DEFINES:= 
# APP_INCLUDES:= -I./src/vendors/GLFW -framework Cocoa -framework OpenGL -framework IOKit -L./src/vendors/GLFW/lib -lglfw3 -std=c++11
# APP_LINKERS:= -L./src/vendors/GLFW/lib -lglfw3

# build:
# 	clang++ $(C_FILES) -o $(BUILD_DIR)/$(APP_NAME) $(APP_INCLUDES) $(APP_LINKERS)
# Compiler and flags
# Compiler and flags
# Compiler and flags
CXX = clang++
CXXFLAGS = -std=c++11 -Wall -Wextra -I./src/vendors/GLFW -I./src/imgui

# Frameworks and libraries
FRAMEWORKS = -framework Cocoa -framework OpenGL -framework IOKit
LIBS = -L/opt/homebrew/lib -lglfw
#-L./src/vendors/GLFW/lib/ -lglfw

# Source directories
SRC_DIR = ./src
IMGUI_DIR = ./src/imgui

# Output directories
APP_NAME = Blank Window
BUNDLE_DIR = $(APP_NAME).app
MACOS_DIR = $(BUNDLE_DIR)/Contents/MacOS
RESOURCES_DIR = $(BUNDLE_DIR)/Contents/Resources
FRAMEWORKS_DIR = $(BUNDLE_DIR)/Contents/Frameworks

# Source files
SRCS = $(SRC_DIR)/main.cpp \
       $(IMGUI_DIR)/imgui.cpp \
       $(IMGUI_DIR)/imgui_draw.cpp \
       $(IMGUI_DIR)/imgui_widgets.cpp \
       $(IMGUI_DIR)/imgui_tables.cpp \
       $(IMGUI_DIR)/imgui_impl_opengl3.cpp \
       $(IMGUI_DIR)/imgui_impl_glfw.cpp

# Output binary
TARGET = $(MACOS_DIR)/blankwindow

# Default target
all: setup_dirs copy_resources build_app

# Create necessary directories for the app bundle
setup_dirs:
	@echo "Creating directory structure..."
	mkdir -p "$(MACOS_DIR)"
	mkdir -p "$(RESOURCES_DIR)"
	mkdir -p "$(FRAMEWORKS_DIR)"

# Copy resources like Info.plist and dynamic libraries
copy_resources: setup_dirs
	@echo "Copying Info.plist and libraries..."
	cp Info.plist "$(BUNDLE_DIR)/Contents/"
	cp ./src/vendors/GLFW/lib/libglfw.3.dylib "$(FRAMEWORKS_DIR)"
	cp ./src/vendors/GLFW/lib/libglfw3.a "$(FRAMEWORKS_DIR)"

# Compile the application and create the executable in the app bundle
build_app: $(SRCS)
	@echo "Compiling the application..."
	$(CXX) $(CXXFLAGS) $(SRCS) -o "$(TARGET)" $(FRAMEWORKS) $(LIBS) -Wl,-rpath,@loader_path/../Frameworks

# Clean up build artifacts
clean:
	@echo "Cleaning up..."
	rm -rf "$(BUNDLE_DIR)"

.PHONY: all setup_dirs copy_resources build_app clean
