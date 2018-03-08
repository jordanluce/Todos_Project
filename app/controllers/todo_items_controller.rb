class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create]
	

	def create
		@todo_item = set_todo_list.todo_items.create(todo_item_params)

		redirect_to todo_list_path(@todo_list)
	end

	def destroy
		set_todo_item
		if set_todo_item.destroy
		 flash[:notice] = "Todo list item was deleted succesfully"
		else
			flash[:alert] = "Todo list item could not be deleted"
		end
		redirect_to todo_list_path(@todo_list) 
	end

	def complete
		set_todo_item.update_attribute(:completed_at, Time.now)
		redirect_to todo_list_path(@todo_list), notice: "Todo_item completed"
	end

	private

	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end

	def set_todo_item
		@todo_item = set_todo_list.todo_items.find(params[:id])
	end

	def todo_item_params
		params.require(:todo_item).permit(:content)
	end
end
