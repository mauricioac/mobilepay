module Mobilepay
    class Client
        module PaymentTransactions

            # Merchants_GetPaymentTransactions
            # Gets the transactions for a given order
            def payment_transactions(args = {})
                response = call(:get, "/merchants/#{merchant_id}/orders/#{args[:order_id]}/transactions", { body: args[:body] || '' })
                JSON.parse(response.body)
            rescue MobilePayFailure => ex
                return { error: ex.message }
            end

        end
    end
end