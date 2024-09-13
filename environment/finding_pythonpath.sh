echo 'export PYTHONPATH=$PYTHONPATH' > environment/setting_pythonpath.sh
find "$PWD" -type d -exec bash -c 'echo export PYTHONPATH=\$PYTHONPATH:{} >> environment/setting_pythonpath.sh' \;
