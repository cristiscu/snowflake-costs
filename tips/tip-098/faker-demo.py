from faker import Faker
import pandas as pd

fake = Faker()
output = [{ "name": fake.name(), "address": fake.address(), "city": fake.city(),
   "state": fake.state(), "email": fake.email() } for _ in range(10000)]
df = pd.DataFrame(output)
print(df)
