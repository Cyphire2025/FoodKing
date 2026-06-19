<template>
  <section class="home-section soft" v-if="offers.length > 0">
    <div class="container">
      <div class="app-section-heading">
        <div class="app-section-heading-left">
          <span class="app-section-kicker">limited time</span>
          <h2 class="app-section-title">{{ $t("label.all_offers") }}</h2>
          <span class="app-section-underline"></span>
        </div>
        <router-link :to="{ name: 'frontend.offers' }" class="app-viewall-link">
          {{ $t("button.view_all") }}
        </router-link>
      </div>
      <div class="home-promo-grid">
        <router-link :to="{ name: 'frontend.offers.item', params: { slug: offer.slug } }" v-for="offer in offers"
          :key="offer" class="home-promo-card">
          <img :src="offer.image" alt="banner" />
        </router-link>
      </div>
    </div>
  </section>
</template>
<script>
import statusEnum from "../../../enums/modules/statusEnum";

export default {
  name: "OfferComponent",
  components: {},
  props: {
    limit: Number,
  },
  data() {
    return {
      loading: {
        isActive: false,
      },
    };
  },
  mounted() {
    try {
      this.loading.isActive = true;
      this.$store.dispatch("frontendOffer/lists", {
        order_column: "id",
        order_type: "desc",
        limit: this.limit,
        status: statusEnum.ACTIVE,
      });
    } catch (err) {
      this.loading.isActive = false;
    }
  },
  computed: {
    offers: function () {
      return this.$store.getters["frontendOffer/lists"];
    },
  },
  methods: {},
};
</script>
