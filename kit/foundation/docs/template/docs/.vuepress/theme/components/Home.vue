<template>
  <main>
      <div class="container">
        <div class="row">
          <div class="col-12 col-lg-8 hero-left">
            <h1 class="hero-title">Cloud Foundation Documentation</h1>
            <p class="desc">
              Welcome to the Cloud Foundation Documentation base of MyOrg! In this documentation base you will be able
              to read about how you can correctly use cloud technologies at MyOrg. For example, you can read which
              regions are not supported in a cloud platform, or who is responsible when a cloud application is down.
              All content is generated based on Infrastructure-as-Code. The documentation is split into three sections:

              <ul>
                <li><b>Foundation:</b> This documents general cloud usage principles that apply, no matter what
                concrete platforms you actually use.</li>
                <li><b>Platform:</b> This documents cloud usage principles of one concrete cloud platform (see section below)</li>
                <li><b>Kit: </b> This documents Infrastructure-as-Code modules that are used to construct the Cloud Foundation.</li>
              </ul>
            </p>
          </div>
          <div class="col-12 col-lg-6">
                <!-- Graphic here? -->
          </div>
        </div>
        <div>
            <router-link to="/maturity-model/" class="btn btn-primary mt-2"
              >Read Foundation Documentation →</router-link
            >
            <!-- Idea: link to the repository of this cloud foundation -->
            <router-link to="/maturity-model/" class="btn btn-secondary ml-2 mt-2"
              >View Source Code →</router-link
            >
        </div>
        <div class="row">
          <div class="col-12">
            <h1>Supported Cloud Platforms</h1>
            <p class="desc">
              The following cloud platforms are supported as part of this cloud foundation:
            </p>
          </div>
        </div>
        <div class="row mb-4">
          <div class="col-6">
              <div class="d-flex p-3 flex-row supported-platform align-items-center">
                <img src="https://swimburger.net/media/ppnn3pcl/azure.png" style="max-width: 100%; max-height: 80px;">
                <div class="ml-4 platform-info flex-column">
                    <span class="font-weight-bold">Microsoft Azure</span>
                    <p>This platform is offered by Micrososft. it is the best platform in the world, you can ask anybody</p>
                    <router-link to="/maturity-model/"
                      >Read Documentation →</router-link
                    >
                </div>
              </div>
          </div>
          <div class="col-6">
              <div class="d-flex p-3 flex-row supported-platform align-items-center">
                <img src="https://lavca.org/app/uploads/2019/10/aws-logo-square.png" style="max-width: 100%; max-height: 80px;">
                <div class="ml-4 platform-info flex-column">
                    <span class="font-weight-bold">AWS</span>
                    <p>This platform is offered by Amazon. it is also quite a cool platform woohoo</p>
                    <router-link to="/maturity-model/"
                      >Read Documentation →</router-link
                    >
                </div>
              </div>
          </div>
        </div>
      </div>
    </main>
</template>

<script>

export default {
  name: 'Home',

  computed: {
    data () {
      return this.$page.frontmatter
    },

    actionLink () {
      return {
        link: this.data.actionLink,
        text: this.data.actionText
      }
    }
  }
}
</script>

<style lang="scss">
.supported-platform {
  border-radius: 5px;
  border: 1px solid var(--c-bg-lighter);
}
</style>
