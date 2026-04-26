onBootstrap((e) => {
    e.next(); 
    console.log("APP_ENV:", process.env.APP_ENV);
    if (process.env.APP_ENV !== "development") {
        return;
    }

    const settings = $app.settings();

    // Debugging purposes - will print every available object method/property to your docker logs
    //console.log("Available on settings:", Object.keys(settings));
    //console.log("Available on $app:", Object.keys($app));

    settings.smtp.enabled = true;
    settings.smtp.host = "mailpit"; 
    settings.smtp.port = 1025;
    settings.smtp.tls = false;

    try {
        $app.save(settings);
        console.log("SUCCESS - Mailpit SMTP configured.");
    } catch (err) {
        console.log("ERROR - Failed configuring Mailpit SMTP: " + err);
    } 
});
