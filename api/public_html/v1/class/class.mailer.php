<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require str_replace("/class", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/PHPMailer/src/Exception.php';
require str_replace("/class", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/PHPMailer/src/PHPMailer.php';
require str_replace("/class", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/PHPMailer/src/SMTP.php';

class Mailer
{
    public function send($to, $toName, $subject, $message, $message_plain) {
        $smtp_server = (new Settings)->findValue('smtp__server');
        $smtp_user = (new Settings)->findValue('smtp__user');
        $smtp_password = (new Settings)->findValue('smtp__password');
        $smtp_port = (new Settings)->findValue('smtp__port');
        $from = (new Settings)->findValue('smtp__from');
        $fromName = (new Settings)->findValue('smtp__from_name');
        
        
        $mail = new PHPMailer(true);
        
        try {
            $mail->setLanguage('br');                             // Habilita as saídas de erro em Português
            $mail->CharSet='UTF-8';                               // Habilita o envio do email como 'UTF-8'
            
            //$mail->SMTPDebug = 3;                               // Habilita a saída do tipo "verbose"
            
            $mail->isSMTP();                                      // Configura o disparo como SMTP
            $mail->Host = $smtp_server;                        // Especifica o enderço do servidor SMTP da Locaweb
            $mail->SMTPAuth = true;                               // Habilita a autenticação SMTP
            $mail->Username = $smtp_user;                        // Usuário do SMTP
            $mail->Password = $smtp_password;                          // Senha do SMTP
            $mail->SMTPSecure = 'tls';                            // Habilita criptografia TLS | 'ssl' também é possível
            $mail->Port = $smtp_port;                                    // Porta TCP para a conexão
            
            $mail->From = $from;                          // Endereço previamente verificado no painel do SMTP
            $mail->FromName = $fromName;                     // Nome no remetente
            $mail->addAddress($to, $toName);// Acrescente um destinatário
            //$mail->addAddress('joao@exemplo.com');                // O nome é opcional
            //$mail->addReplyTo('info@exemplo.com', 'Informação');
            //$mail->addCC('cc@exemplo.com');
            //$mail->addBCC('bcc@exemplo.com');
            
            $mail->isHTML(true);                                  // Configura o formato do email como HTML
            
            $mail->Subject = $subject;
            $mail->Body    = $message;
            $mail->AltBody = $message_plain;
            
            $mail->send();
            return true;
        } catch (Exception $e) {
            return $mail->ErrorInfo;
        }
    }
}
?>
