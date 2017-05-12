var domain = location.hostname.split('.');
backend_url='http://phonebook-backend.'+domain.slice(1,domain.length).join('.');
