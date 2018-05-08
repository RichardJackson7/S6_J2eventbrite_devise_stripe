class EventsController < ApplicationController

	def new
		@event = Event.new
	end

	def create
		@user = current_user 
		@event = Event.new(event_params)
		@event.creator_id = current_user.id
		@event.save
		redirect_to events_path
	end

	def index
		@events = Event.all 
	end

	def show
		@event = Event.find(params[:id])
	end

	def subscribe
		@user = current_user
		@event = Event.find(params[:id])
	    if @event.attendees.include? current_user
		    flash[:error] = "You are already in!" 
		    redirect_to events_path		    
	    end
	
	 	# Amount in cents
  		@amount = @event.price

		customer = Stripe::Customer.create(
		    :email => params[:stripeEmail],
		    :source  => params[:stripeToken]
		  )

		charge = Stripe::Charge.create(
		    :customer    => customer.id,
		    :amount      => @amount,
		    :description => 'PAY',
		    :currency    => 'eur'
		  )

		@event.attendees << current_user
		    flash[:success] = "Now, you are in!" 
		    redirect_to events_path

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to events_path
	end

	private
  	def event_params
      params.require(:event).permit(:description, :date, :place)
  	end

end