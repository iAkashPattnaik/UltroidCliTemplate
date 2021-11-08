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
RUN ver=$(curl https://raw.githubusercontent.com/BLUE-DEVIL1134/UltroidCli/main/version.txt) && curl -L -o ultroid https://github.com/BLUE-DEVIL1134/UltroidCli/releases/download/$ver/ultroid.exe

# Clone the repository and install the dependencies
RUN ./ultroid init

# Create a new [.env] file
RUN ./ultroid env.create new

# Set the Variables in [.env] file
# For heroku, first set the variables in setings/config-vars and then deploy
RUN ./ultroid env.set API_ID $apiId
RUN ./ultroid env.set API_HASH $apiHash
RUN ./ultroid env.set SESSION $session
RUN ./ultroid env.set REDIS_URI $redisUri
RUN ./ultroid env.set REDIS_PASSWORD $redisPassword
RUN ./ultroid env.set HEROKU_API $herokuApi
RUN ./ultroid env.set HEROKU_APP_NAME $herokuAppName

# Print the versions
# Absolutely not required in heroku but, me is premoting UltroidCli
RUN ./ultroid version

# Run Ultroid
CMD ["./ultroid", "run"]
