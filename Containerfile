FROM arm64v8/ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y && \
    apt install -y software-properties-common -y && \
    add-apt-repository universe && \
    apt install -y curl git wireless-tools && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu jammy main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
    apt update -y && \
    apt upgrade -y && \
    apt install -y ros-humble-ros-base && \
    apt install -y ros-humble-irobot-create-msgs && \
    apt install -y build-essential python3-colcon-common-extensions python3-rosdep ros-humble-rmw-cyclonedds-cpp python3-pip && \
    echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc
WORKDIR /opt
RUN git clone https://github.com/SVC-Sigmap/irc3-system.git && \
    pip install -r irc3-system/requirements.txt
# EXPOSE 8080/tcp
# EXPOSE 8080/udp
# CMD ["/opt/irc3-system/main.py"]
CMD ["/bin/bash", "-c", "source /opt/ros/humble/setup.bash;/opt/irc3-system/main.py"]
