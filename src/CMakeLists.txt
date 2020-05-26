cmake_minimum_required( VERSION 3.14 )

find_library(date-tz REQUIRED)

project( DateEnv VERSION 0.0.1 )
add_executable( date_env main.cpp )
# target_sources( date.env PRIVATE main.cpp )
target_link_libraries( date_env PRIVATE date-tz  )









