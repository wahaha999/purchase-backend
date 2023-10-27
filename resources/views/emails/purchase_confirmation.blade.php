<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            max-width: 600px;
            margin: auto;
            background-color: #f7f7f7;
            color: #333;
            border-radius: 10px;
        }

        .container {
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            line-height: 1.5;
        }

        .footer {
            margin-top: 20px;
            font-size: 14px;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Thank you for your purchase, {{ $details['buyer_name'] }}!</h1>
        
        <p>You have successfully purchased the following item:</p>
        <p><strong>Product:</strong> {{ $details['product_name'] }}</p>
        <p><strong>Price:</strong> ${{ $details['product_price'] }}</p>
        <p><strong>Purchase Date:</strong> {{ $details['purchase_date'] }}</p>
        
        <p>If you have any questions regarding your purchase, please do not hesitate to contact us.</p>
        
        <div class="footer">
            Best Regards, <br>
            Purchase-App Team
        </div>
    </div>
</body>
</html>
