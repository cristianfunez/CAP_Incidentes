using { sap.capire.incidents as my } from '../db/schema';

/**
 * Service used by support personell, i.e. the incidents' 'processors'.
 */
service ProcessorService { 
    entity Incidents as projection on my.Incidents;

    @readonly
    entity Customers as projection on my.Customers;
}

// Anotacione para permitir borradores
annotate ProcessorService.Incidents with @odata.draft.enabled; 

// Anotacion para restringir roles a entidades
annotate ProcessorService with @(requires: 'support');

/**
 * Service used by administrators to manage customers and incidents.
 */
service AdminService {
    entity Customers as projection on my.Customers;
    entity Incidents as projection on my.Incidents;
    }

// Anotacion para restringir roles a entidades
annotate AdminService with @(requires: 'admin');