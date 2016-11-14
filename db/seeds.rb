User.create!(
  name: "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true,
  country: "Admin country",
  state: "Admin state",
  phone: "1234567890")

20.times do |n|
  name = "User#{n+1}"
  email = "example-#{n+1}@gmail.com"
  password = "123456"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    country: "User#{n+1} country",
    state: "User#{n+1} state",
    phone: "1234567890")
end

10.times do |n|
  Category.create( name: "Camera #{n+1}", content: "Camera #{n+1}")
end
cate = Category.order(:created_at)
cate.each { |cate|
  10.times do |n|
    product = cate.products.create(name: cate.name + "Product #{n+1}",
      user_id: User.first,
      description: "Product#{n+1} Product#{n+1} Product#{n+1}",
      detail: "detail#{n+1} detail#{n+1} detail#{n+1}",
      image: File.open("/home/duytung/Ki 9/ITJP/download (1).jpg"),
      price: 10000,
      promotion: 2,
      is_display: true
)
  end
}

product = Product.order(:created_at)
product.each {|product|
  4.times do
    product.product_images.create(
      image: File.open("/home/duytung/Ki 9/ITJP/download (1).jpg")
    )
  end
}
