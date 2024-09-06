using ProcessorService as service from '../../srv/services';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Cliente}',
                Value : customer_ID,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Detalles}',
            ID : 'i18nDescripcionGeneral',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Detalles',
                    ID : 'Detalles',
                    Target : '@UI.FieldGroup#Detalles',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Conversacion',
            ID : 'Conversacion',
            Target : 'conversation/@UI.LineItem#Conversacion',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : '{i18n>StatusDescripcion}',
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.name,
            Label : '{i18n>UrgenciaDesscripcin}',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.firstName,
            Label : 'firstName',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.lastName,
            Label : 'lastName',
        },
    ],
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : customer.firstName,
        },
        TypeImageUrl : 'sap-icon://alert',
    },
    UI.FieldGroup #Detalles : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
            },
        ],
    },
);

annotate service.Incidents with {
    customer @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'firstName',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
        },
        Common.Text : {
            $value : customer.firstName,
            ![@UI.TextArrangement] : #TextOnly
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Incidents with {
    status @(
        Common.Label : '{i18n>Estado}',
        Common.Text : status.descr,
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Incidents with {
    urgency @(
        Common.Label : '{i18n>Urgencia}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Urgency',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : urgency_code,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Prueba Label',
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : urgency.name,
    )
};

annotate service.Urgency with {
    code @Common.Text : name
};

annotate service.Customers with {
    ID @Common.Text : firstName
};

annotate service.Status with {
    code @Common.Text : descr
};

annotate service.Incidents.conversation with @(
    UI.LineItem #Conversacion : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : '{i18n>Autor}',
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : '{i18n>Mensaje}',
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : '{i18n>Fecha}',
        },
    ]
);

