<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Purchase;
use Illuminate\Http\Request;
use Stripe\Stripe;
use Stripe\Checkout\Session as StripeSession;
use Stripe\PaymentIntent;
use Stripe\Charge;
use Stripe\Customer;
use Stripe\PaymentMethod;
use App\Mail\PurchaseConfirmation;
use Illuminate\Support\Facades\Mail;

class ProductController extends Controller
{
    public function create(Request $request)
    {
        Product::create([
            'name' => $request->input('name'),
            'description' => $request->input('description'),
            'image' => $request->input('image'),
            'type' => $request->input('type'),
            'price' => $request->input('price')
        ]);
        return response(['status' => 1], 200);
    }

    public function get()
    {
        $products = Product::all();
        return response($products, 200);
    }

    public function checkout(Request $request)
    {
        $productId = $request->input('product_id');
        $product = Product::find($productId);


        $totalAmount = $product->price;
        // Charge the customer using Stripe
        Stripe::setApiKey(env('STRIPE_SECRET'));
        $stripeSession = \Stripe\Checkout\Session::create([
            'payment_method_types' => ['card'],

            'line_items' => [
                [
                    'price_data' => [
                        'currency' => 'usd',
                        'product_data' => [
                            'name' => 'Your Online Store Order',
                        ],
                        'unit_amount' => $totalAmount * 100,
                    ],
                    'quantity' => 1,
                ],
            ],
            'mode' => 'payment',
            'success_url' => env("FRONTEND_URL") . "/purchase?status=1",
            'cancel_url' => env("FRONTEND_URL") . "/purchase?status=0",
        ]);



        return response($stripeSession, 200);
    }

    public function updateUser(Request $request)
    {
        $product_id = $request->product_id;
        $session_id = $request->session_id;

        $user = auth()->user();
        $product = Product::find($product_id);

        if ($product->type === 'b2c') {
            $user->role = 'b2c';
        } else if ($product->type === 'b2b') {
            $user->role = 'b2b';
        }
        $user->save();

        $this->getTransactionDetails($session_id, $user->id, $product_id);


        $details = [
            'product_name' => $product->name,
            'product_price' => $product->price,
            'buyer_name' => $user->name,
            'purchase_date' => now()->toFormattedDateString(),
        ];

        Mail::to($user->email)->send(new PurchaseConfirmation($details));

        return response($user, 201);
    }


    public function getTransactionDetails($sessionId, $user_id, $product_id)
    {
        Stripe::setApiKey(env('STRIPE_SECRET'));

        // 1. Get the checkout session details
        $session = StripeSession::retrieve($sessionId);

        // 2. Get the payment intent details
        $paymentIntent = PaymentIntent::retrieve($session->payment_intent);

        // // 3. Get the charge details
        // $chargeId = $paymentIntent->charges->data[0]->id;
        $charge = Charge::retrieve($paymentIntent->latest_charge);

        // // 4. Get the customer and card details
        // $customerId = $charge->customer;
        // $customer = Customer::retrieve($customerId);

        // $paymentMethodId = $charge->payment_method;
        // $paymentMethod = PaymentMethod::retrieve($paymentMethodId);

        Purchase::create([
            'user_id' => $user_id,
            'product_id' => $product_id,
            'session_id' => $sessionId,
            'card_num' => $charge->payment_method_details->card->last4,
            'card_brand' => $charge->payment_method_details->card->brand,
            'receipt_url' => $charge->receipt_url,
        ]);

        return 0;
    }


    public function getPurchases()
    {
        $user = auth()->user();

        $purchases = Purchase::with('product')->where('user_id', $user->id)->get();

        return response($purchases, 201);
    }
}
