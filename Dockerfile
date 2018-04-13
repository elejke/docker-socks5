FROM wernight/dante

# TODO: Replace 'john' and 'MyPassword' by any username/password you want.
RUN printf 'MyPassword\nMyPassword\n' | adduser john
