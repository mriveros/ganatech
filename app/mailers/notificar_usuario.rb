class NotificarUsuario < ActionMailer::Base
  
  default from: "smarthub.py@gmail.com"

  def test_email(user_id, subject ,adjuntos, modulo)

    @modulo = modulo
    @datos_adjuntos = adjuntos
    @subject = subject
    @user = Usuario.find_by_id user_id

    if (@user)

      usuario = @user.email
      mail(:to => usuario, :subject => @subject, :from => "smarthub.py@gmail.com") 
    
    end
    
  end



  def email(usuario, password)
    
    @usuario = usuario
    @password = password

    mail(to: @usuario.email, subject: "ULTRON: Nuevo Usuario")

  end

  def email_usuario(usuario, password)
    
    @usuario = usuario
    @password = password

    mail(to: @usuario.email, subject: "ULTRON: Nuevo Usuario")

  end

  def email_recuperar_password(usuario, password)
    
    @usuario = usuario
    @password = password

    mail(to: @usuario.email, subject: "ULTRON: Recuperar Contraseña")

  end

  def enviar_notificacion(email, subject ,adjuntos, modulo)

    @modulo = modulo
    @datos_adjuntos = adjuntos
    @subject = subject
    @email = email

    if (@email)

      mail(:to => @email, :subject => @subject, :from => "smarthub.py@gmail.com") 
    
    end

  end

  

end
