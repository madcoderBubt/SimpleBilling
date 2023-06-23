import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app/app.module';

export function getBaseUrl() {
  //return document.getElementsByTagName('base')[0].href;
  return "http://localhost:28724/";
}

const providers = [
  { provide: 'BASE_URL', useFactory: getBaseUrl, deps: [] }
];


platformBrowserDynamic(providers).bootstrapModule(AppModule)
  .catch(err => console.error(err));
