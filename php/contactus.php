<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $name = $_POST["name"];
    $email = $_POST["email"];
    $message = $_POST["message"];
    $subject = $_POST["subject"];

    
    $to = "yassine1sehli@gmail.com";

    
    $headers = "From: $name <$email>\r\n";
    $headers .= "Reply-To: $email\r\n";

    
    if (mail($to, $subject, $message, $headers)) {
        echo json_encode(array('result'=>"Your message has been sent successfully!",'status'=>true));
    } else {
        echo json_encode(array('result'=>"Sorry, there was a problem sending your message.",'status'=>true));
    }
}
?>