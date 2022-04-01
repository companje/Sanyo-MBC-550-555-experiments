%ifdef use_abs8
abs8:
    or al,al
    jns .return
    neg al
.return ret
%endif