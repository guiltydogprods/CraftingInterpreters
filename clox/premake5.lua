-- premake5.lua
	
workspace "clox"
	configurations { "Debug", "Release" }
	platforms { "x64", "ARM64" }   
--	includedirs { ".", "engine" }
	defines { "_CRT_SECURE_NO_WARNINGS" }
 
filter { "action:vs*", "platforms:x64" }
	system "windows"
	architecture "x86_64"  
	vectorextensions "SSE4.1"
	toolset "msc-clangcl"
    defines("RE_PLATFORM_WIN64")    
	includedirs { "..", "../external/glfw-3.3.2/include", "../external/glew-2.1.0/include", "../external/fmod/api/core/inc", "../external/stb" }

filter "action:xcode*"
   system "macosx"
   architecture "ARM64"
   vectorextensions "NEON"
   toolset "clang"
   defines { "MACOS" }    
   local sdkpath = os.getenv("VULKAN_SDK")
   buildoptions { "-Xclang -flto-visibility-public-std -fblocks" }
   linkoptions { "-framework Cocoa -framework IOKit -framework CoreFoundation -framework IOSurface -framework Metal -framework QuartzCore" }
   sysincludedirs { "external/glfw-3.3/include", sdkpath .. "/Include" } --, "external" }
   includedirs { "..", "source", "external/stb" } --, "extenral/threads" }
   libdirs { "external/glfw-3.3/lib-macos", sdkpath .. "/lib" }
--   links { "glfw3", "vulkan" }
   defines { "ARM64", "RE_PLATFORM_MACOS", "RE_RENDERING_PLATFORM_VULKAN" }

filter "configurations:Debug"
	defines { "_DEBUG" }

filter "configurations:Release"
	defines { "NDEBUG" }

project "clox"
	location "clox"
	kind "ConsoleApp"
	language "C"
	targetdir "bin/%{cfg.buildcfg}"   	
	debugdir "."
	buildoptions { "-Xclang -flto-visibility-public-std" }
	editandcontinue "Off"
	
	files 
	{ 
		"clox/**.h", 
		"clox/**.c",
	}

	excludes
	{	
	}

	filter { "action:vs*" }
		removeplatforms { "ARM64" }

	filter "configurations:Debug"
		defines { "_DEBUG" }
		optimize "Off"
		symbols  "Full"      

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "Full"

