class ChargesController < ApplicationController
	
	def new
		@post = Post.find params[:post_id]
	end

	def create
	  # Amount in cents
	  @amount = 500

	  customer = Stripe::Customer.create(
	    :email => 'example@stripe.com', # :stripeEmail did not work: "Your API key is invalid, as it contains whitespace"
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'Instabean coffee',
	    :currency    => 'usd'
	  )

	  flash[:notice] = 'Thanks for the $5!'
	  redirect_to '/posts'

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end
end