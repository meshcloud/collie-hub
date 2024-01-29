# FAQ

### Does the collie hub contain production-ready kit modules?

Yes! Many of the modules published on collie hub reuse terraform code made available by cloud providers in Frameworks like Azure Enterprise Scale or Google Cloud Fast Fabric.
They also follow conceptual best-practices developed by the [cloudfoundation.org](https://cloudfoundation.org) community published in the [Cloud Foundation Maturity Model](https://cloudfoundation.org/maturity-model/).

### Do I have to be familiar with terraform and terragrunt to use collie?

You should be familiar with terraform in order to use collie effectively. Collie offers an opinionated workflow that lends itself to building
complex landing zones and uses `terragrunt` to accomplish this. Familiarity with terragrunt is not required,
though you will most likely find it useful to pick up some of its concepts along the way.

### Where can I get help with collie?

Building a Landing Zone is an extensive and multi-faceted challenge. You need to understand the technical and
organizational aspects and implement them for your organization.

You can join us on the [cloudfoundation.org](https://cloudfoundation.org) community slack for discussion around landing
zones.

::: tip 🌤 meshcloud Landing Zone Accelerator
meshcloud's Landing Zone accelerator
is a compact professional services offering that delivers an out-of-the box best-practices landing zone while also
helping you build the capability and confidence to build and operate your landing zones. Learn more at [meshcloud.io](https://www.meshcloud.io/en/services/landing-zone-accelerator/).
:::

If you find any technical issues please raise them on GitHub for [Collie CLI](http://github.com/meshcloud/collie-cli/) or [Collie Hub](http://github.com/meshcloud/collie-hub/).

### Do I have to use `collie` cli for working with the Collie Hub?

Not necessarily - `collie` cli transparently invokes other tools like `terragrunt` for you. You can see every command that collie invokes using the `--verbose` flag.
However, collie offers a comfortable developer workflow and many useful utilities to help you inspect your cloud foundation.


### I have to use a proxy, how to I configure collie and its tools to use it?

It could be that your company only communicates with the Internet via a proxy and therefore the required packages cannot be downloaded.
If you are using Microsoft Windows, you can set the proxy with the following commands in a Powershell running as administrator.
To find the proxy address, consult the person responsible for the network.

```Powershell
# npm proxy setup packages for collie dependencies
npm config set proxy http://proxy.company.com:8080
npm config set https-proxy http://proxy.company.com:8080

# if you use a developer platform like github you have to set a proxy here as well`
git config --global http.https://domain.com.proxy http://proxyUsername:proxyPassword@proxy.server.com:port

# Terraform uses the proxy via Windows environment variables
$proxy='http://192.168.1.100:8080'
$ENV:HTTP_PROXY=$proxy
$ENV:HTTPS_PROXY=$proxy
```

### terragrunt does not work due to the limited length of file paths under windows.

It could be that the file length in your Windwos operating system is limited to 260 characters. You can find more information here.
[Maximum Path Length Limitation](https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=registry)

```Powershell
git config --global core.longpaths true

New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" `
-Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force
```

