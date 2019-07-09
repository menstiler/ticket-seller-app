class TicketsController < ApplicationController
  def index

    Ticket.all.each do |ticket|
      if "#{ticket.date} #{ticket.time}" > Time.now()
        ticket.update(status: true)
      else
        ticket.update(status: false)
      end
    end

    tickets = Ticket.all.select do |ticket|
      ticket.status
    end
    render json: tickets
  end

  def show
    ticket = Ticket.find(params[:id])
    render json: ticket
  end

  def create
    ticket = Ticket.create(ticket_params)
    if "#{ticket.date} #{ticket.time}" >  Time.now()
      ticket.update(status: true)
    else
      ticket.update(status: false)
    end
    render json: ticket
  end

  def destroy
    ticket = Ticket.find(params[:id])
    ticket.delete
  end

  def update
    ticket = Ticket.find(params[:id])
    ticket.update(ticket_params)
    ticket.update(status: true)
    render json: ticket
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :location, :time, :category, :min_price, :buy_now, :status, :seller_id, :date)
  end
end
