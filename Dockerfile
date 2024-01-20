FROM wernight/dante

# TODO: Replace 'john' and 'MyPassword' by any username/password you want.
ENV PASS FeelAgain2024
RUN printf "${PASS}\n${PASS}\n" | adduser vvkarelin
