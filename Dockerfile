# UltroidCli
# Copyright (C) 2021 Akash Pattnaik
#
# This file is a part of < https://github.com/BLUE-DEVIL1134/UltroidCli/ >
# PLease read the GNU Affero General Public License in
# <https://www.github.com/BLUE-DEVIL1134/UltroidCli/blob/main/LICENSE/>.

FROM theteamultroid/ultroid:main

# Set Timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set workfir
RUN mkdir /UltroidCli
WORKDIR /UltroidCli

# download the latest release from github
RUN ver=$(curl https://raw.githubusercontent.com/BLUE-DEVIL1134/UltroidCli/main/version.txt) && curl -L -o ultroid https://github.com/BLUE-DEVIL1134/UltroidCli/releases/download/$ver/ultroid-linux

# Give Permissions
RUN chmod u+x ultroid

# Clone the repository and install the dependencies
RUN ./ultroid init

# Install Dependencies
RUN pip install -U pip \
    && pip install --no-cache-dir -r TeamUltroid/requirements.txt \
    && pip install install av --no-binary av

# Run Ultroid
CMD ["./ultroid", "heroku"]
