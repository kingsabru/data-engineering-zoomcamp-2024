ARG MAGE_AI_VERSION

FROM mageai/mageai:${MAGE_AI_VERSION}

ARG USER_CODE_PATH=/home/src/${PROJECT_NAME}

# Note: this overwrites the requirements.txt file in your new project on first run.
# You can delete this line for the second run :)
COPY requirements.txt ${USER_CODE_PATH}requirements.txt

RUN pip3 install -r ${USER_CODE_PATH}requirements.txt
