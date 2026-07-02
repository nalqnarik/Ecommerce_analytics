from faker import Faker
import pandas as pd
import random

fake = Faker()

categories = pd.DataFrame({
    "category_id": [1, 2, 3, 4, 5],
    "category_name": [
        "Electronics",
        "Books",
        "Clothing",
        "Home",
        "Sports"
    ]
})

categories.to_csv("categories.csv", index=False)

product_catalog = {
    "Electronics": [
        "Apple MacBook Air M3",
        "Dell Inspiron 15",
        "HP Pavilion Laptop",
        "Lenovo ThinkPad X1",
        "Asus ROG Strix Laptop",
        "Samsung Galaxy S25",
        "Apple iPhone 16",
        "Google Pixel 10",
        "Sony WH-1000XM5 Headphones",
        "Logitech MX Master 3S Mouse",
        "Razer BlackWidow Keyboard",
        'Samsung 27" Monitor',
        "LG UltraWide Monitor",
        "Canon EOS R50 Camera",
        "GoPro HERO13",
        "JBL Flip 6 Speaker",
        "Apple Watch Series 10",
        "Anker Power Bank",
        "Kingston 1TB SSD",
        "TP-Link WiFi Router"
    ],

    "Books": [
        "Python Programming",
        "SQL for Data Analysis",
        "Machine Learning with Python",
        "Deep Learning",
        "Data Science Handbook",
        "Statistics Essentials",
        "Business Analytics",
        "Artificial Intelligence",
        "Clean Code",
        "Design Patterns",
        "Database Systems",
        "Marketing Fundamentals",
        "Financial Analysis",
        "Linear Algebra",
        "The Pragmatic Programmer",
        "Atomic Habits",
        "The Lean Startup",
        "Thinking in SQL",
        "Python Crash Course",
        "Algorithms Unlocked"
    ],

    "Clothing": [
        "Nike Air Max 270",
        "Adidas Essentials Hoodie",
        "Levi's 501 Jeans",
        "Puma Running Shoes",
        "Under Armour T-Shirt",
        "North Face Jacket",
        "Uniqlo Polo Shirt",
        "Zara Summer Dress",
        "H&M Sweatshirt",
        "Tommy Hilfiger Sweater",
        "Calvin Klein Socks",
        "Columbia Shorts",
        "New Balance Sneakers",
        "Champion Joggers",
        "Reebok Training Shorts",
        "Gap Hoodie",
        "Converse Chuck Taylor",
        "Wrangler Denim Jacket",
        "Nike Sports Cap",
        "Adidas Backpack"
    ],

    "Home": [
        "Philips Air Fryer XL",
        "Dyson Vacuum Cleaner",
        "Nespresso Coffee Machine",
        "IKEA Markus Chair",
        "IKEA Linnmon Desk",
        "KitchenAid Mixer",
        "Tefal Cookware Set",
        "Panasonic Microwave",
        "Black+Decker Toaster",
        "Philips Desk Lamp",
        "Wooden Bookshelf",
        "Memory Foam Pillow",
        "Cotton Blanket",
        "Wall Clock",
        "Knife Set",
        "Water Filter",
        "Electric Kettle",
        "Dining Table",
        "Office Desk",
        "LED Floor Lamp"
    ],

    "Sports": [
        "Wilson Basketball",
        "Adidas Football",
        "Yonex Tennis Racket",
        "Nike Yoga Mat",
        "Bowflex Dumbbells",
        "Fitbit Charge 6",
        "Garmin Forerunner 965",
        "Resistance Bands",
        "Skipping Rope",
        "Camping Tent",
        "Sleeping Bag",
        "Swimming Goggles",
        "Bicycle Helmet",
        "Protein Shaker",
        "Golf Ball Set",
        "Treadmill",
        "Exercise Bike",
        "Foam Roller",
        "Boxing Gloves",
        "Hiking Backpack"
    ]
}

category_mapping = {
    "Electronics": 1,
    "Books": 2,
    "Clothing": 3,
    "Home": 4,
    "Sports": 5
}

price_ranges = {
    1: (100, 2500),
    2: (10, 120),
    3: (20, 300),
    4: (30, 1500),
    5: (15, 1000)
}
products = []

product_id = 1

for category_name, product_list in product_catalog.items():

    category_id = category_mapping[category_name]
    min_price, max_price = price_ranges[category_id]

    for product_name in product_list:

        products.append({

            "product_id": product_id,

            "product_name": product_name,

            "category_id": category_id,

            "price": round(random.uniform(min_price, max_price), 2),

            "stock_quantity": random.randint(20, 500)

        })

        product_id += 1

products_df = pd.DataFrame(products)

products_df.to_csv("products.csv", index=False)

customers = []

for customer_id in range(1, 501):

    customers.append({

        "customer_id": customer_id,

        "first_name": fake.first_name(),

        "last_name": fake.last_name(),

        "email": fake.unique.email(),

        "city": fake.city(),

        "country": fake.country(),

        "registration_date": fake.date_between(
            start_date="-5y",
            end_date="today"
        )

    })

customers_df = pd.DataFrame(customers)

customers_df.to_csv("customers.csv", index=False)

orders = []

statuses = [
    "Completed",
    "Pending",
    "Cancelled"
]

for order_id in range(1, 3001):

    orders.append({

        "order_id": order_id,

        "customer_id": random.randint(1, 500),

        "order_date": fake.date_between(
            start_date="-2y",
            end_date="today"
        ),

        "status": random.choices(

            statuses,

            weights=[80, 10, 10]

        )[0]

    })

orders_df = pd.DataFrame(orders)

orders_df.to_csv("orders.csv", index=False)

order_items = []

order_item_id = 1

for order_id in orders_df["order_id"]:

    number_of_products = random.randint(1, 5)

    selected_products = products_df.sample(number_of_products)

    for _, product in selected_products.iterrows():

        order_items.append({

            "order_item_id": order_item_id,

            "order_id": order_id,

            "product_id": int(product["product_id"]),

            "quantity": random.randint(1, 5),

            "unit_price": float(product["price"])

        })

        order_item_id += 1

order_items_df = pd.DataFrame(order_items)

order_items_df.to_csv("order_items.csv", index=False)

payments = []

for order in orders_df.itertuples():

    order_items_subset = order_items_df[
        order_items_df["order_id"] == order.order_id
    ]

    total_amount = (
        order_items_subset["quantity"] *
        order_items_subset["unit_price"]
    ).sum()

    payments.append({

        "payment_id": order.order_id,

        "order_id": order.order_id,

        "payment_method": random.choices(

            ["Card", "Cash", "PayPal"],

            weights=[65, 15, 20]

        )[0],

        "payment_date": order.order_date,

        "amount": round(total_amount, 2)

    })

payments_df = pd.DataFrame(payments)

payments_df.to_csv("payments.csv", index=False)