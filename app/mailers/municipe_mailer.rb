class MunicipeMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def welcome_email 
      @municipe = params[:municipe]
      mail(to: @municipe.email, subject: 'Bem vindo ao municipe')
    end
    def alteracao_email
      @municipe = params[:municipe]
      mail(to: @municipe.email, subject: 'Bem vindo ao municipe')
    end
end
