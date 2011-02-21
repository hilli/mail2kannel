class Mail2kannel
  require "mail"
  require "fssm"

  def watch_maildir(maildir="/home/smsgate/.maildir")
    FSSM.monitor(maildir, '**/*') do
      create do |base, relative|
        read_mail(base,relative)
      end
    end
  end

  def read_mail(base, relative)

  end
end
