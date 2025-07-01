# https://github.com/jpetazzo/dockvpn
# https://github.com/kylemanna/docker-openvpn
FROM alpine:latest

ADD ./bin /usr/local/bin
ADD ./otp/openvpn /etc/pam.d

RUN apk upgrade --no-cache && \
    apk add --no-cache tzdata openvpn iptables bash easy-rsa openvpn-auth-pam google-authenticator pamtester libqrencode && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    chmod a+x /usr/local/bin/* && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

ENV OPENVPN=/etc/openvpn \
    EASYRSA=/usr/share/easy-rsa \
    EASYRSA_CRL_DAYS=3650 \
    EASYRSA_PKI=$OPENVPN/pki

VOLUME ["/etc/openvpn"]

EXPOSE 1194/udp

CMD ["ovpn_run"]