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

# download the latest release from github
RUN ver=$(curl https://raw.githubusercontent.com/BLUE-DEVIL1134/UltroidCli/main/version.txt) && curl -L -o ultroid https://github.com/BLUE-DEVIL1134/UltroidCli/releases/download/$ver/ultroid-linux

# Give Permissions
RUN chmod u+x ultroid

# Clone the repository and install the dependencies
RUN ./ultroid init

# Print the versions
# Absolutely not required in heroku but, me is premoting UltroidCli
RUN ./ultroid version

# Create Env File
RUN ./ultroid env.create new

# Run Ultroid
CMD ["./ultroid", "heroku"]
