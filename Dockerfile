FROM wernight/dante

# TODO: Replace 'john' and 'MyPassword' by any username/password you want.
ENV PASS MyPassword
RUN printf '${PASS}\n${PASS}\n' | adduser john
