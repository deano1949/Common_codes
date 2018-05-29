function contract=contractmaker(Type,Symbol,varargin)
%varargin={currency,exchange,includeExpired,primaryExch}
    switch Type
        case 'STK'
            if nargin==2
                contract = com.tws.ContractFactory.GenericStockContract(Symbol);
            else
                contract=com.ib.client.Contract();
                contract.m_secType='STK';
                contract.m_symbol=Symbol;
                contract.m_exchange=varargin{2};
                contract.m_currency=varargin{1};
            end
        case 'OPT'
            if nargin==2
                contract = com.tws.ContractFactory.GenericStockContract(Symbol);
                contract.m_secType = 'OPT'; 
                contract.m_primaryExch = [];
            end
        case 'FUT'
            contract=com.ib.client.Contract();
            contract.m_secType='FUT';
            contract.m_localSymbol=Symbol;
            contract.m_exchange=varargin{2};
            contract.m_currency=varargin{1};
            contract.m_includeExpired=1;
    end
