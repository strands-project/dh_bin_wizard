cmake_minimum_required(VERSION 2.8.3)
project(mira_installer)

add_custom_target(mira ALL
    COMMAND bash ${CMAKE_SOURCE_DIR}/mira-installer.sh
)


install(CODE "MESSAGE(\"no install step necessary.\")")
