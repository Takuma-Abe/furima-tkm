# credentialsの記述に変更（ENV['PAYJP_SECRET_KEY']）
Webpacker::Compiler.env["PAYJP_PUBLIC_KEY"] = ENV["PAYJP_PUBLIC_KEY"]
# Webpacker::Compiler.env["PAYJP_PUBLIC_KEY"] = Rails.application.credentials.payjp[:pc_key]

# require_relative '../application'
# require_relative '../webpacker_env'