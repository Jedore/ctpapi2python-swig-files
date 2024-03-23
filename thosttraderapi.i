%module(directors="1") thosttraderapi
%{
#include "ThostFtdcTraderApi.h"
#include "iconv.h"
%}
%typemap(out) char[ANY], char[] {
    if ($1) {
        iconv_t cd = iconv_open("utf-8", "GBK");
        if (cd != (iconv_t)(-1)) {
            char buf[4096] = {};
            char **in = &$1;
            char *out = buf;
            size_t inlen = strlen($1), outlen = 4096;

            if (iconv(cd, in, &inlen, &out, &outlen) != (size_t)(-1))
			{
                $result = SWIG_FromCharPtrAndSize(buf, sizeof buf - outlen);
			}
            iconv_close(cd);
        }
    }
}
%feature("python:annotations", "c");
%feature("director") CThostFtdcTraderSpi;
%ignore THOST_FTDC_VTC_BankBankToFuture;
%ignore THOST_FTDC_VTC_BankFutureToBank;
%ignore THOST_FTDC_VTC_FutureBankToFuture;
%ignore THOST_FTDC_VTC_FutureFutureToBank;
%ignore THOST_FTDC_FTC_BankLaunchBankToBroker;
%ignore THOST_FTDC_FTC_BrokerLaunchBankToBroker;
%ignore THOST_FTDC_FTC_BankLaunchBrokerToBank;
%ignore THOST_FTDC_FTC_BrokerLaunchBrokerToBank;

%include "ThostFtdcUserApiDataType.h"
%include "ThostFtdcUserApiStruct.h"
%include "ThostFtdcTraderApi.h"