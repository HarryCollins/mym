class MarketOutcomePresenter < BasePresenter

	include Rails.application.routes.url_helpers

	def create_bet_hash(bet_collection, user = User.all)
		bet_groups_hash = Hash.new
		bet_groups = bet_collection.by_user(user).group_by(&:odds)
		bet_groups = bet_groups.sort_by{|key, values| key}.reverse
		bet_groups.each do |odds, bet_group|
        	bet_groups_hash[odds] = bet_group.inject(0) {|sum, bet| sum + bet.original_amount }
	    end
	    
	    return bet_groups_hash
	end

	def bet_button(odds, amount, direction)
		h.content_tag :span, class: bet_button_class(direction) do
			h.content_tag(:span, "#{odds}") +
			h.tag(:br) +
			h.content_tag(:span, "(£#{amount})")
		end
	end

	def new_bet_button(direction, user)
		h.content_tag :span, class: bet_button_class(direction) do
			h.link_to "New", new_market_outcome_lay_path(self, user)
		end
	end

	private

		def bet_button_class(direction)
			case direction
				when :back
					"btn btn-sm btn-primary pull-left margin_1px"
				when :lay
					"btn btn-sm btn-danger pull-right margin_1px"
				when :newback
					"btn btn-info pull-right glyphicon glyphicon glyphicon-plus"
				when :newlay
					"btn btn-info pull-left glyphicon glyphicon glyphicon-plus"
			end
		end


end