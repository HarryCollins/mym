class MarketsController < ApplicationController

	before_action :require_user, except: [:show, :index]
	before_action :require_founder, only: [:edit, :update, :destroy, :complete]

	def index
		@markets = Market.all
		@markets = Market.founded_by_user(current_user) if params[:founder].present?
		@markets = Market.joined_by_user(current_user) if params[:joined].present?
	end

	def show
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)
		@message = Message.new
	end

	def new
		@market = Market.new
		#create blank outcome
		1.times { @market.market_outcomes.build }
	end

	def create
		@market = Market.new(market_params)
		@market.user_markets << UserMarket.new(user: current_user, is_founder: true)
	    if @market.save(market_params)
			flash[:success] = "You have sucessfully created this market"
			redirect_to market_path(@market)
	    else
	      render :new
	    end
	end

	def edit
		@market = Market.find(params[:id])
		if @market.market_outcomes.empty?
			1.times { @market.market_outcomes.build }
		end
	end
	
	def update
		@market = Market.find(params[:id])
	    if @market.update(market_params)
	      flash[:success] = "You have sucessfully updated this market"  
	      redirect_to market_path(@market)
	    else
	      render :edit
	    end
	end
	
	def destroy
		@market = Market.find(params[:id])
		destroy_market_validation = Validations::DestroyMarketValidation.new(@market)
		if destroy_market_validation.can_destroy?
		    if @market.destroy
			    flash[:success] = "Market Deleted"
			    redirect_to markets_path	    	
		    else
		    	render :edit	    	
		    end
		else
			destroy_market_validation.add_errors
			render :edit	
		end
	end

	def complete
		market = Market.find(params[:id])
		market.update(market_status_id: 3)
		@market = MarketPresenter.new(market, view_context)

		redirect_to market_path(@market)
	end

	def join
		market = Market.find(params[:id])
		@user_market = market.user_markets.build(user: current_user)
		@market = MarketPresenter.new(market, view_context)

		respond_to do |format|
			if @user_market.save
				format.html { redirect_to market_path(@market) }
				format.js { }
			else	
				format.html { redirect_to market_path(@market) }	
			end
		end	
	end

	def leave
		market = Market.find(params[:id])
		@user_market = market.user_markets.where(user: current_user).first
		@market = MarketPresenter.new(market, view_context)

		leave_market_validation = Validations::LeaveMarketValidation.new(@market, current_user)

		if leave_market_validation.can_leave?

			@user_market = market.user_markets.where(user: current_user).first
			@market = MarketPresenter.new(market, view_context)

			respond_to do |format|
				if @user_market.destroy
					format.html { redirect_to market_path(@market) }
					format.js { }
				else	
					format.html { redirect_to market_path(@market) }	
				end
			end

		else

			leave_market_validation.add_errors
			flash[:danger] = @market.errors.full_messages.to_sentence
			render js: "window.location = '#{market_path(@market)}'"
		end

	end

	private
	
	def market_params
		params.require(:market).permit(:name, :description, :market_type_id, :market_status_id, market_outcomes_attributes: [:id, :outcome, :_destroy])	
	end

	def render_user(user)
		render(partial: 'user', locals: { user: user })
	end

	def market_founder?(market)
		!!(market.mkfounder == current_user)
	end

	def require_founder
		if not market_founder?(Market.find(params[:id]))
		  flash[:danger] = "You need to be the market founder see this page"
		  redirect_to root_path
		end
	end

end

