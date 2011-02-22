module Mail2kannel
  require "mail"
  require "fssm"
  require "inifile"
  require "mail2kannel/chr_convert"
  require "pp"

  @@ini = IniFile.load(File.expand_path("../../.mail2kannel", __FILE__))
  @debug = @@ini['config']['debug']
  puts "initializing" if @debug

  def self.watch_maildir(maildir=@@ini['config']['maildir'])
    puts "monitoring #{File.expand_path(File.join(maildir,"new"))} for incoming messages" if @debug
    FSSM.monitor(File.expand_path(File.join(maildir,"new")), '**/*') do
      create do |base, relative|
        Mail2kannel::read_mail(File.join(base,relative))
      end
    end
  end

  def self.read_mail(email_file)
    puts "Reading email from #{email_file}" if @debug
    mail = Mail.read(email_file)
    subject = mail.subject
    body = ""
    charset = "UTF-8"
    if mail.multipart?
      #Multipart - Find text part
      mail.parts.map do |p|
        if p.content_type.match(/text\/plain/)
          body = p.body.decoded
          charset = p.content_type_parameters['charset']
        end
      end
    else
      body = mail.body.decoded
      charset = mail.content_type_parameters['charset']
    end
    p subject if @debug
    p body if @debug
    to = find_recipient_number(mail.to)
    pp to if @debug
    if @@ini['config']['clean_maildir']
      File.unlink email_file
    end
    send_to_kannel(to, subject + "\n" + body, charset)
  end

  # Translate the To addresses to an array ofphone number(s)
  # from the recipients map
  def self.find_recipient_number(to)
    to.map do |t|
      name, domain = t.split("@")
      @@ini['recipients'][name] if domain == @@ini['config']['maildomain']
    end.compact
  end

  def self.send_to_kannel(to, message, encoding="UTF-8")
    
  end

end
