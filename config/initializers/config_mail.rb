ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: '587',
  authentication: 'login',
  enable_starttls_auto: true,
  user_name: "xxxx",
  password: "xxx",
  domain: "smtp.gmail.com",
  ssl: false
}