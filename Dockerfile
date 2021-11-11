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

# ENV vars
ARG API_ID
ARG API_HASH
ARG SESSION
ARG REDIS_URI
ARG REDIS_PASSWORD
ARG HEROKU_API
ARG HEROKU_APP_NAME

# download the latest release from github
RUN ver=$(curl https://raw.githubusercontent.com/BLUE-DEVIL1134/UltroidCli/main/version.txt) && curl -L -o ultroid https://github.com/BLUE-DEVIL1134/UltroidCli/releases/download/$ver/ultroid-linux

# test
RUN ls -la

# Give Permissions
RUN chmod u+x ultroid

# Clone the repository and install the dependencies
RUN ./ultroid init

# Create a new [.env] file
RUN ./ultroid env.create new

# Set the Variables in [.env] file
# For heroku, first set the variables in setings/config-vars and then deploy
RUN ./ultroid env.API_ID ${apiId}
RUN ./ultroid env.API_HASH ${apiHash}
RUN ./ultroid env.SESSION ${session}
RUN ./ultroid env.REDIS_URI ${redisUri}
RUN ./ultroid env.REDIS_PASSWORD ${redisPassword}
RUN ./ultroid env.HEROKU_API ${herokuApi}
RUN ./ultroid env.HEROKU_APP_NAME ${herokuAppName}

# Print the versions
# Absolutely not required in heroku but, me is premoting UltroidCli
RUN ./ultroid version

# Run Ultroid
CMD ["./ultroid", "run"]
