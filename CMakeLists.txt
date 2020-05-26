cmake_minimum_required( VERSION 3.14 )

project( DateEnv VERSION 0.0.1 )

option(BUILD_SHARED_LIBS ON)


add_subdirectory(date)
add_subdirectory(src)
