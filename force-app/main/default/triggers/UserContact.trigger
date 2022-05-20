trigger UserContact on User (after insert) {
    contact c = new contact();
    for(user u: Trigger.new){ 
        c.LastName = u.LastName;
        c.Email= u.Email;
        c.MailingCity = u.City;
        c.MailingCountry = u.Country;
        c.MailingStreet = u.Street;
        c.MailingState = u.State;
        c.MailingPostalCode = u.PostalCode;
        c.MailingLatitude = u.Latitude;
        c.MailingLongitude = u.Longitude;
        c.MailingGeocodeAccuracy = u.GeocodeAccuracy;
        c.Description = 'Contact Created automatically by the trigger with the user data ';
    }
    insert c;
    system.debug('contact=='+c); 
}